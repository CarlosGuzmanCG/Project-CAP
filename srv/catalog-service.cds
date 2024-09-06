using {com.cg as cg} from '../db/schema';
using {com.training as training} from '../db/training';

service CatalogService {
    entity Products as projection on cg.materials.Products;
    entity Suppliers as projection on cg.sales.Suppliers;

    entity Currency as projection on cg.materials.Currencies;
    entity DimensionUnit as projection on cg.materials.DimensionUnits;
    entity Category as projection on cg.materials.Categories;
    entity SalesData as projection on cg.sales.SalesData;
    entity Reviews as projection on cg.materials.ProductReview;

    entity Order as projection on cg.sales.Orders;
    entity OrderItem as projection on cg.sales.OrderItems;

    entity UnitOfMeasures as projection on cg.materials.UnitOfMeasures;
    entity Months as projection on cg.sales.Months;

    
}
