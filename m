From: Simon Guinot <simon.guinot@sequanux.org>
Date: Tue, 19 Jun 2018 10:07:10 +0000
Subject: EPD IT8951 and fbdev support
Message-Id: <20180619100710.GJ19100@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HnQK338I3UIa/qiP"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I do have a board with an EPD controller from ITE connected via USB. The
model is IT8951. Tt reports as an USB mass storage device and the whole
programming interface is based is based on SCSI commands.

While SCSI is quite convenient to control the device from userland (via
ioctl SG_IO), I don't know how to write a fbdev driver from it. Indeed,
I don't think it is possible to send SCSI commands from a fbdev driver.

On the other hand, I don't think there is some userland support either
to implement a fbdev driver (like FUSE for filesystems).

So I am asking here for ideas about how to get framebuffer support on a
such device, and maybe a little bit of guidance as well :)

Thanks in advance.

Simon

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAlso1c4ACgkQzyg/RDPm
szpmpBAArewSwgDC34cd7/bXraXT6+La9rWVU8cO5z47REI0fDb5Ilr7s3wIJKb1
HKFkqi/WMyyeQ8dQlbY/LlF0r9b1cLHdxIc1uP+PkPJs1C05RTRiAnJ8edt3Iu+H
P6YAIr5R74HTJWgUgrQV+ETX14f0PW+W0JnXVN/lFTpfi01v+lQEUsPrNinHjp42
kQBuAuywvp0moy8M5eM/SZ3qPOeknNgPw4A5F63g7q5P7a16o9FoalMQan9tJ9hE
xZ2utuBqtbWfhPLMZPRYXIhjo8hjHXLVIJuYtQCKxDVQAegvnsu8BJ0C51EM/TIV
Ty+1YSRteDPyEYCGtUNtNpuZAf8EogSRajVzfjzsAViyR9Hm5B3AUSIsJvA64X3G
tpETyrwVCw+LAG+3wGrpngQBdbl+5CP5Vyeq9z2afyLNl+Ezd6rIr5cq8UwGWy+e
p+sXopUyDDQn7r2S/o+UMpHsur61PQfJgZWYFdp9d41Rp6kOcu95fAj1bhgXTSB7
6TbKZR6kJJcifixXHJk8bjj95G6270cenJ237Y4ng7EuDYCi/qayj0+C5vq45sM9
W36Bk9UoKeAFAKz45dpjb1Q/RDcoAsiIQh8Or91qj++Dh7NryI+nxxSSkQCNYps5
cEvf5JLFqJymZ5+o5miBTD7xY+SHuB0ddYusdUygz+VwTRiOrbI=
=MTbC
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
