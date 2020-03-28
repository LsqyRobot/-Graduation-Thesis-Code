function noise_t = noise(t,tp,peak,fat)
noise_t = peak*exp(-fat*(t-tp).^2);
end