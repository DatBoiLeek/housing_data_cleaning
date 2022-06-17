USE housingproject;

#Updating table to add nulls to empty strings------------------------------------------------------------------------

UPDATE 
nashville_housing
SET
ParcelID = CASE ParcelID WHEN '' 
THEN NULL ELSE ParcelID END,

LandUse = CASE LandUse WHEN '' 
THEN NULL ELSE LandUse END,

PropertyAddress = CASE PropertyAddress WHEN '' 
THEN NULL ELSE PropertyAddress END,
SaleDate = CASE SaleDate WHEN '' 
THEN NULL ELSE SaleDate END,

SalePrice = CASE SalePrice WHEN '' 
THEN NULL ELSE SalePrice END,

LegalReference = CASE LegalReference WHEN '' 
THEN NULL ELSE LegalReference END,

SoldAsVacant = CASE SoldAsVacant WHEN '' 
THEN NULL ELSE SoldAsVacant END,

OwnerName = CASE OwnerName WHEN '' 
THEN NULL ELSE OwnerName END,

OwnerAddress = CASE OwnerAddress WHEN '' 
THEN NULL ELSE OwnerAddress END,

Acreage = CASE Acreage WHEN '' 
THEN NULL ELSE Acreage END,

TaxDistrict = CASE TaxDistrict WHEN '' 
THEN NULL ELSE TaxDistrict END,

LandValue = CASE LandValue WHEN '' 
THEN NULL ELSE LandValue END,

BuildingValue = CASE BuildingValue WHEN '' 
THEN NULL ELSE BuildingValue END,

TotalValue = CASE TotalValue WHEN '' 
THEN NULL ELSE TotalValue END,

YearBuilt = CASE YearBuilt WHEN '' 
THEN NULL ELSE YearBuilt END,

Bedrooms = CASE Bedrooms WHEN '' 
THEN NULL ELSE Bedrooms END,

FullBath = CASE FullBath WHEN '' 
THEN NULL ELSE FullBath END,

HalfBath = CASE HalfBath WHEN '' 
THEN NULL ELSE HalfBath END;

/*
Cleaning Data Queries-----------------------------------------------------------------------------------------------------------------
*/

# ParcelID & Property Address contains data redundancies
SELECT *
FROM nashville_housing
ORDER BY ParcelID;

# Test Join table onto itself to find all data redundancies in ParcelID & Property Address.
# If a.Property Address is null, populate it with the b.Property Address)
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, IFNULL(a.PropertyAddress, b.PropertyAddress)
FROM nashville_housing a
INNER JOIN nashville_housing b
ON  a.ParcelID  = b.ParcelID
AND a.UniqueID !=  b.UniqueID
WHERE a.PropertyAddress IS NULL;

#Update the nashville table using aliases to get rid of null values (join onto itself).
UPDATE nashville_housing a
	INNER JOIN nashville_housing b
	ON  a.ParcelID  = b.ParcelID
	AND a.UniqueID !=  b.UniqueID
SET 
	a.PropertyAddress = IFNULL(a.PropertyAddress, b.PropertyAddress)
WHERE a.PropertyAddress IS NULL;

# Re-run select statement and ensure that each row of ParcelId & PropertyAddress does NOT contain data redundancies
SELECT *
FROM nashville_housing
ORDER BY ParcelID;

