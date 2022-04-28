function [timediff, norm] = Magnetic_Test(data)
    %% Data Extraction
    % 3:x, 4:y, 5:z, 6:azimuth, 7:elevation, 8:roll, 11:time
    x_val = data.Var3;
    y_val = data.Var4;
    z_val = data.Var5;
    azimuth = data.Var6;
    elevation = data.Var7;
    roll = data.Var8;
    time = data.Var11;

    %% Data Processing
    timediff = time-time(1);
    full_data = [x_val-x_val(1) y_val-y_val(1) z_val-z_val(1)]';
    norm = vecnorm(full_data);
