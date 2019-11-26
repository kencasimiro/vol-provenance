CC=mpicc
HDF5_DIR=../hdf5/
CFLAGS=-I$(HDF5_DIR)/include -L$(HDF5_DIR)/lib
LIBS=-lhdf5
TARGET=libh5prov.so

# Testcase section
TEST_C_FLAGS = -m64 -DUSE_V4_SSE -DOMPI_SKIP_MPICXX -DPARALLEL_IO
TEST_LIB_FLAGS   = -L $(HDF5_BUILD_DIR)/src/.libs -L./ -lh5prov -lhdf5 -lz -lm -ldl
TEST_SRC = vpicio_uni_h5.c
TEST_BIN = vpicio_uni_h5

all: makeso test

makeso:
	$(CC) -shared $(CFLAGS) $(LIBS) -o $(TARGET) -fPIC H5VLprovnc.c
#mpicc -shared -I../hdf5/include -L../hdf5/lib -lhdf5 -o $(TARGET) -fPIC H5VLprovnc.c

test:
	$(CC)  -o $(TEST_BIN) $(CFLAGS) $(TEST_C_FLAGS) $(TEST_LIB_FLAGS) $(TEST_SRC)
