config = {}

config.baus = {
    {
        name = "Prefeitura", -- Nome do Baú (Se colocar nomes iguais os baús se duplicam)
        position = vector3(-79.07, -1723.6, 29.35), -- Coordenadas (/cds2)
        weight = 15000, -- Tamanho
        perm = "admin.permissao", -- Permissão
        webhook = "URL_DO_WEBHOOK" -- Url logs
    }, -- *Não esqueça das virgulas*
    {
        name = "Teste2", 
        position = vector3(-72.82, -1722.55, 29.35), 
        weight = 4299,
        perm = "admin.permissao", 
        webhook = "URL_DO_WEBHOOK"
    },
}

return config