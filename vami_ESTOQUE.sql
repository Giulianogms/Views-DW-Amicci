CREATE OR REPLACE VIEW vami_ESTOQUE AS (

SELECT QE.DATA_ESTOQUE DATA_ATUALIZACAO, QE.SEQPRODUTO, QE.NRO_EMPRESA EMPRESA,
       QE.QTDE_MEDIA_VENDA * QP.PRECO VLR_MEDIO_VDA,
       QE.QTDE_MEDIA_VENDA QTD_MEDIA_VDA, QP.QTDE_LOJA ESTOQUE_QTD,
       QP.QTDE_LOJA * QP.PRECO ESTOQUE_VLR,
       QE.QTDE_PENDENCIA_COMPRA QTD_PEDERTO

FROM QLV_ESTOQUECALCULADO QE 
     LEFT JOIN QLV_PRODUTOEMPRDIA QP ON QE.SEQPRODUTO = QP.SEQPRODUTO AND QE.NRO_EMPRESA = QP.NRO_EMPRESA AND QE.DATA_ESTOQUE = QP.DATA 
     
WHERE QE.DATA_ESTOQUE = TRUNC(SYSDATE - 1)

);
