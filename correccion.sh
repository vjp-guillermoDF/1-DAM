#!/bin/bash
echo "Realizando auditoría en tu sistema, por favor espere."
sleep 5
echo "El resultado del análisis es:"
for user in usuario1 usuario2; do
    if id "$user" &>/dev/null; then
        echo "✓ El usuario $user existe."
    else
        echo "ERROR: El usuario $user no existe."
    fi
done
if [[ $(chage -l usuario1 | grep "Maximum number of days between password change" | awk '{print $NF}') -eq 30 ]]; then
    echo "✓ La contraseña de usuario1 expira en 30 días."
else
    echo "ERROR: La expiración de la contraseña de usuario1 no es de 30 días."
fi
if [[ $(chage -l usuario2 | grep -i "password must be changed") ]]; then
    echo "✓ Usuario2 debe cambiar su contraseña en el próximo inicio de sesión."
else
    echo "ERROR: Usuario2 no tiene activada la obligación de cambio de contraseña."
fi
errors=0
if grep -Eq "^PASS_MAX_DAYS[[:space:]]+90" /etc/login.defs; then
    echo "✓ Las contraseñas expiran en 90 días."
else
    echo "ERROR: PASS_MAX_DAYS no está configurado en 90 días."; errors=$((errors+1))
fi
if grep -Eq "^PASS_MIN_DAYS[[:space:]]+1" /etc/login.defs; then
    echo "✓ Se requiere un mínimo de 1 día antes de cambiar contraseña."
else
    echo "ERROR: PASS_MIN_DAYS no está configurado en 1 día."; errors=$((errors+1))
fi
if grep -Eq "^PASS_WARN_AGE[[:space:]]+7" /etc/login.defs; then
    echo "✓ Se muestra advertencia 7 días antes del vencimiento de la contraseña."
else
    echo "ERROR: PASS_WARN_AGE no está configurado en 7 días."; errors=$((errors+1))
fi
dpkg -l | grep -q libpam-pwquality
if [[ $? -eq 0 ]]; then
    echo "✓ libpam-pwquality está instalado."
else
    echo "ERROR: libpam-pwquality no está instalado."
fi
pwq_config_file="/etc/security/pwquality.conf"
if grep -q "minlen = 12" "$pwq_config_file" && \
   grep -q "dcredit = -1" "$pwq_config_file" && \
   grep -q "ucredit = -1" "$pwq_config_file" && \
   grep -q "lcredit = -1" "$pwq_config_file" && \
   grep -q "ocredit = -1" "$pwq_config_file"; then
    echo "✓ Las reglas de complejidad de contraseña están configuradas correctamente."
else
    echo "ERROR: No todas las reglas de complejidad de contraseña están configuradas correctamente."
fi
echo "Revisión completada."
