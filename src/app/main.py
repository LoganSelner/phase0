from fastapi import FastAPI

app = FastAPI(title="Phase0 Template")


@app.get("/health")
def health() -> dict:
    return {"ok": True}
