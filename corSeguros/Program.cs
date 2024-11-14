using corSeguros.Models;
using corSeguros.Repositories.Implementations;
using corSeguros.Repositories.Interfaces;
using corSeguros.Services.Implementations;
using corSeguros.Services.Repositories;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<BBDDAseguradoraContext>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnections")));
builder.Services.AddScoped<ISegurosService, SegurosService>();
builder.Services.AddScoped<IClienteRepository, ClienteRepository>();
builder.Services.AddScoped<ICotizacionesRepository, CotizacionesRepository>();
builder.Services.AddScoped<IVehiculosRepository, VehiculosRepository>();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

var app = builder.Build();
app.UseCors("AllowAll");

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

