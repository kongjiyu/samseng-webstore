INSERT INTO "Account" (username, email, password, role, dob)
VALUES (
           'jo',
           'jooe@example.com',
           encode('securepassword', 'base64'),
           'USER',
           '1995-05-20'
       );

INSERT INTO "Address" (user_id, address_name, contact_no, address_1, address_2, address_3, postcode, state, country, is_default)
VALUES (
           'AC0001', -- 关联的 Account `user_id`
           'Home',
           '+60123456789',
           '123 Main Street',
           'Apt 4B',
           'Downtown',
           '50000',
           'Kuala Lumpur',
           'Malaysia',
           false
       );

INSERT INTO "Cart_Product" (product_id, user_id, quantity)
VALUES (
           'PR0001',
           'AC0001',
           2
       );

INSERT INTO "Comment" (rating, message, products_id, user_id)
VALUES (
           4.5, -- 评分（必须）
           'This is a great product!', -- 评论内容（最多 200 字）
           'PR0001', -- 关联的 Products `products_id`
           'AC0001' -- 关联的 Account `user_id`
       );



