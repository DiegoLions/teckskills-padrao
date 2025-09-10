CREATE TABLE clientes(
    id SERIAL PRIMARY KEY,
    nome VARCHAR (100) NOT NULL,
    cpf VARCHAR (11) NOT NULL,
    email VARCHAR (100),
    data_nasc DATE,
    data_cadastro TIMESTAMP DEFAULT now ()

);

CREATE TABLE enderecos(
    id (PK) SERIAL,
    logradouro VARCHAR (150) NOT NULL,
    cep VARCHAR (8) NOT NULL,
    numero VARCHAR (10) NOT NULL,
    bairro VARCHAR (60),
    complemento VARCHAR (100),
    referencia VARCHAR (200),
    cidade VARCHAR (100) NOT NULL,
    uf VARCHAR (2) NOT NULL

)

CREATE TABLE enderecos_cliente(
    cliente_id (FK) (PK) INTEGER,
    endereco_id (FK) (PK) INTEGER,
    tipo VARCHAR (30) NOT NULL CHECK('entrega', 'cobranca'),
CONSTRAINT pk_enderecos_cliente PRIMARY KEY (cliente_id, endereco_id),
CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES cliente(id),
CONSTRAINT fk_endereco FOREIGN KEY (endereco_id) REFERENCES enderecos(id)
)

CREATE TABLE pedidos(
    id (PK) SERIAL,
    cliente_id (PK) INTEGER NOT NULL,
    descricao VARCHAR (100)
    data_pedido TIMESTAMP NOT NULL,
    data_entrega TIMESTAMP NOT NULL,
    
    CONSTRAINT fk_cliente_pedido FOREIGN KEY (cliente_id)
        REFERENCES clientes(id)
)

CREATE TABLE itens(
    id (PK) SERIAL,
    nome VARCHAR (100) NOT NULL,
    descricao VARCHAR (500)
    valor NUMERIC (10,2) NOT NULL ,
    tempo_preparo INTERVAL,
    imagem VARCHAR (200)
)

CREATE TABLE item_pedido(
    item_id (FK) (PK) INTEGER,
    pedido_id (FK) (PK) INTEGER,
    quantidade INTEGER NOT NULL CHECK (quantidade>0),

    CONSTRAINT pk_item_pedido PRIMARY KEY (item_id, pedido_id),
    CONSTRAINT fk_item FOREIGN KEY (item_id)
        REFERENCES itens(id),
    CONSTRAINT fk_pedidos FOREIGN KEY (pedido_id)    
        REFERENCES pedido(id)
)