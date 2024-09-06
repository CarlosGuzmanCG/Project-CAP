namespace com.training;

// type EmailAddress_01: many{ Type matriz of array of
//     kind : String;
//     email : String;
// };

// type EmailAddress_02{
//     kind : String;
//     email : String;
// };

// entity Emails {
//     email_01 : EmailAddress_01;
//     email_02 : many EmailAddress_02;
//     email_03 : many {
//         kind : String;
//         email : String;
//     }
// };

// type Gender : String enum{
//     male;
//     femele;
// };

// entity Order {
//     clienGender : Gender;
//     Status : Integer enum {
//         submitted = 1;
//         fulfiller = 2;
//         shipped = 3;
//         cancel = -1;
//     };
//     priority : String @assert.range enum {
//         high;
//         medium;
//         low;
//     }
// };

// entity Car {
//     key ID                 : UUID;
//         name               : String;
//         virtual discount_1 : Decimal;
//         @Core.Computed: false
//         virtual discount_2 : Decimal;
// };

// entity Suppliers_01 {
//     key ID      : UUID;
//         Name    : String;
//         Address : Address;
//         Email   : String;
//         Phone   : String;
//         Fax     : String;
// };

// entity Suppliers_02 {
//     key ID      : UUID;
//         Name    : String;
//         Address : {
//             Street     : String;
//             City       : String;
//             State      : String(2);
//             PostalCode : String(5);
//             Country    : String(3);
//         };
//         Email   : String;
//         Phone   : String;
//         Fax     : String;
// };

// Entities with Parameters

// entity ParamProducts(pName : String) as
//     select from Products{
//         Name,
//         Price,
//         Quantity
//     }
//     where Name = : pName;

//associations: Many a Many
entity Course : cuid {
    //key ID      : UUID;
    Student : Association to many StudentCourse
                  on Student.Course = $self;
};

entity Student : cuid {
    //key ID     : UUID;
    Course : Association to many StudentCourse
                 on Course.Student = $self;
}

entity StudentCourse : cuid {
    //key ID      : UUID;
    Student : Association to Student;
    Course  : Association to Course;
}
//*----*