-- =====================================================
-- Script: Actualizar ENUM de sync_mode en github_integration
-- Fecha: 2025-12-15
-- Proposito: Agregar nuevos valores al ENUM sync_mode
-- =====================================================

USE dev_portal_sql;

-- Modificar la columna sync_mode para incluir los nuevos valores
ALTER TABLE github_integration 
MODIFY COLUMN sync_mode ENUM(
    'MANUAL',
    'AUTO_PUSH',
    'AUTO_PULL',
    'BIDIRECTIONAL',
    'API_ONLY',
    'WEBHOOK',
    'CLONE_LOCAL'
) DEFAULT 'MANUAL' 
COMMENT 'Modo de sincronizacion con GitHub';

-- Actualizar registros existentes de API_ONLY a MANUAL
UPDATE github_integration 
SET sync_mode = 'MANUAL' 
WHERE sync_mode = 'API_ONLY';

-- Verificar los cambios
SELECT 
    github_integration_id,
    repositorio_id,
    github_repository_fullname,
    sync_mode,
    auto_sync_enabled,
    is_active
FROM github_integration;
