From: Felipe Balbi <balbi@kernel.org>
Date: Mon, 11 Feb 2019 13:30:40 +0000
Subject: Re: [PATCH 12/18] fotg210-udc: remove a bogus dma_sync_single_for_device call
Message-Id: <87mun25u67.fsf@linux.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-13-hch@lst.de> <87d0obodci.fsf@linux.intel.com> <20190201161026.GE6532@lst.de> <20190211131243.GA21917@lst.de>
In-Reply-To: <20190211131243.GA21917@lst.de>
Cc: Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Christoph Hellwig <hch@lst.de> writes:
> On Fri, Feb 01, 2019 at 05:10:26PM +0100, Christoph Hellwig wrote:
>> On Fri, Feb 01, 2019 at 03:19:41PM +0200, Felipe Balbi wrote:
>> > Christoph Hellwig <hch@lst.de> writes:
>> >=20
>> > > dma_map_single already transfers ownership to the device.
>> > >
>> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
>> >=20
>> > Do you want me to take the USB bits or will you take the entire series?
>> > In case you're taking the entire series:
>>=20
>> If you want to take the USB feel free.  I just want most of this in
>> this merge window if possible.
>
> I didn't see in the USB tree yet, so please let me know if you want to
> take it.

sorry for the delay, just took it to my tree.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxheQAACgkQzL64meEa
mQYzFg/4muRUpGlUEIEF7m9XPk3QIX8Pzn3aMhhLD7ucF6/5HvJqCFtSWHhlMFTm
rFr30ro355hllOJnoWLoNfJY3T3cu8PMJ5IQ2365YdA+4CsmjZXUrcRe5WXAw/9Y
lTgoKjRqyPgQ8pvDZcm5fWI738c74q/bdlaGmZEJ/Gnvx4V7J+VTwvZSWpzuWO+R
R5BlvRd9D/WRvJjijfSnxH8e8bHQdzvOZBp3w1/xFfq7R/1ETCj5WIbQShh+EmEm
32rDZZoXO5QM2vduoknOdvOxAaBYtmP98HIlpcZZad+cEmIzAIU/J73F7cNdDpFX
+9Uwan4LKbx39nimqGAGDFLKgm/RfTZ2f/kAnUroGbV9RB+cTcaFJD4jbLkFF0lt
fszk5GE9EmONRYNdVUrZKDN/vuC5nIfrFckYMoEvHhbYWesSK7xPX6ULy7FqLfmX
SVSfjhs4hyc4RC2M6ahpOEdiLmfioBX7fXWgN3wMQDS4wwt5Nu8tnuep/RZbfGDu
13d2LNqpjvAX5wpyflLRZUeHSN7mPQGyS1w3i1ecVFo0BN99YNbwL72p0F1nSti4
/bVCOR74cnliLlMOly3IExJCVTksMVLa/4rWpP3s/EF1OnCq7HhTcoyU9ctkaeFc
YwL+7FWJm932YAw8lv0o5P6Tahvbl1CH4h0aw4Lkyw5XWIBxXQ==
=9V6B
-----END PGP SIGNATURE-----
--=-=-=--
