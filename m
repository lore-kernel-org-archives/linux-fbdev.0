From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 19 Nov 2012 09:36:24 +0000
Subject: Re: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
Message-Id: <50A9FD98.1060105@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigEE7C38F0BC9B9BB9A191E5AC"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
 <ADE657CA350FB648AAC2C43247A983F00206B2644F3F@AUSP01VMBX24.collaborationhost.net>
 <50A9C1C4.5070907@ti.com> <20121119091504.GB3290@n2100.arm.linux.org.uk>
In-Reply-To: <20121119091504.GB3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--------------enigEE7C38F0BC9B9BB9A191E5AC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-19 11:15, Russell King - ARM Linux wrote:
> On Mon, Nov 19, 2012 at 10:51:08AM +0530, Archit Taneja wrote:
>> On Friday 16 November 2012 10:14 PM, H Hartley Sweeten wrote:
>>> On Friday, November 16, 2012 2:16 AM, Archit Taneja wrote:
>>>>
>>>> This removes the sparse warnings on arm platforms:
>>>>
>>>> warning: cast removes address space of expression
>>>>
>>>> Signed-off-by: Archit Taneja <archit@ti.com>
>>>
>>> I submitted the same patch around early March 2012. So FWIW:
>>>
>>> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>
>> Thanks.
>>
>> Florian,
>>
>> Could you queue this for 3.8 merge window?
>=20
> Actually no.  Has anyone checked whether this has any impact for the BE=

> ARM platforms?

Probably not. I can't say anything to that matter, but I wonder if this
patch is just going around the problem that we get sparse warnings when
falling into the else ifdef block in fb.h.

The macros in the else block are defined as:

#define fb_readb(addr) (*(volatile u8 *) (addr))                         =
       =20

And fb code passes a pointer to __iomem. So shouldn't the cast be to
(volatile u8 __iomem *)?

 Tomi



--------------enigEE7C38F0BC9B9BB9A191E5AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQqf2YAAoJEPo9qoy8lh712AkQAKEMp/idhjJik/A5kFGWcLdC
nm4HVZKUeLM3pKbHdBYDrkvkMuSAAhTmhxcvoEVy/XC6TIqiDtlk6juSEl1h+zll
vKqmpRqGX/r2lFixPhIqoe7vsLCzrAP7xwaM8zSOCQSrzsNZ34x2IpAWN7deXq8P
HHxq5/45wnYF3nPShTPi/2FO1WcRiWSs0XW+aStyf9A0w3ZrpS1w0XHuHqRmY3oN
PM0GY1hxcTKZml5+9N0az3OXLGZUNneOhv6gKibKY8CGWu2GOKjKQf6+BzF67e33
z6eMjrkQBR+xOOwJgXpw5Xrz/ozCWkeY5FKLLiv+Fgtei9hbqEbigZDyjrs2ISTI
/4WASPgQq6YWjlgwj1BTZ+f+eqpB6M9Luw5q04LCRIEmd9n0EnPqWtjgRgFNNPXt
498o205VhaKgS4J+HztOaJlUdDgoTV0wwu1yL6IxQEVlt/GcaeB9eUIF+LeMoCa/
AMw18jaEmx27JTbwlrR3pf/fKk6I1WwWsPAe1XLTDseZO4S8/lMbezKj8wGW0UsE
4/FujckmfKhEj4yeEdhd0/bLDR0ULy5hw8y7WuYPTD3wo1EsVs0MncwWbrlQpCLQ
yQBXtAG4CLc832zNdrYnH4SSAvmV+tiWv29zghiWbUKKsLh/zeiv2LX5Rs0Doz2X
c4jpdQp0UVqxAEWQU/3u
=Rilb
-----END PGP SIGNATURE-----

--------------enigEE7C38F0BC9B9BB9A191E5AC--
