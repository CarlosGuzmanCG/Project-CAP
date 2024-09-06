using {com.cg as cg} from '../db/schema';

service CatalogService {
    entity Products as projection on cg.Products;
    entity Suppliers as projection on cg.Suppliers;

    entity Currency as projection on cg.Currencies;
    entity DimensionUnit as projection on cg.DimensionUnits;
    entity Category as projection on cg.Categories;
    entity SalesData as projection on cg.SalesData;
    entity Reviews as projection on cg.ProductReview;

    entity Order as projection on cg.Orders;
    entity OrderItem as projection on cg.OrderItems;

    entity UnitOfMeasures as projection on cg.UnitOfMeasures;
    entity Months as projection on cg.Months;

    //entity Car as projection on cg.Car
    //entity Suppliers_01 as projection on cg.Suppliers_01;
}
