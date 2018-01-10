From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 10 Jan 2018 14:43:02 +0000
Subject: Re: [-next PATCH 2/4] treewide: Use DEVICE_ATTR_RW
Message-Id: <41847882-9ad9-aeb1-009b-2f9b2fdb656e@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1513706701.git.joe@perches.com>
 <cd38f14f06e1f447b3159ffe8c69c0df8241bb6e.1513706701.git.joe@perches.com>
 <20171220083403.GA27231@bitmer.com> <1513761884.1234.83.camel@perches.com>
 <20171220093211.GA16177@kroah.com> <20171220105404.GA29856@bitmer.com>
In-Reply-To: <20171220105404.GA29856@bitmer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, linux-s390@vger.kernel.org, linux-omap@vger.kernel.org, "James E.J.
 Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, James Smart <james.smart@broadcom.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dick Kennedy <dick.kennedy@broadcom.com>, Mathias Nyman <mathias.nyman@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, intel-gfx@lists.



On 2017-12-20 12:54, Jarkko Nikula wrote:
> On Wed, Dec 20, 2017 at 10:32:11AM +0100, Greg Kroah-Hartman wrote:
>> On Wed, Dec 20, 2017 at 01:24:44AM -0800, Joe Perches wrote:
>>> On Wed, 2017-12-20 at 10:34 +0200, Jarkko Nikula wrote:
>>>> On Tue, Dec 19, 2017 at 10:15:07AM -0800, Joe Perches wrote:
>>>>> Convert DEVICE_ATTR uses to DEVICE_ATTR_RW where possible.
>>> []=20
>>>>> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
>>> []
>>>>> @@ -854,7 +854,7 @@ static ssize_t dma_op_mode_store(struct device *d=
ev,
>>>>>  	return size;
>>>>>  }
>>>>> =20
>>>>> -static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, dma_op_mode_=
store);
>>>>> +static DEVICE_ATTR_RW(dma_op_mode);
>>>>> =20
>>>>
>>>> While I can ack this part here if it helps generic cleanup effort I
>>>> don't understart would it improve code readability in general? Mode 644
>>>> is clear and don't need any grepping but for DEVICE_ATTR_RW() I had to=
 go
>>>> through all of these files in order to see what does it mean:
>>
>> Yeah, 644 is "clear", but _RW() is even more clear.  Ideally I want to
>> get rid of all of the "non-standard" users that set random modes of
>> sysfs files, as we get it wrong too many times.  Using the "defaults" is
>> much better.
>>
> Fair enough. For the sound/soc/omap/ (Acked-by was missing from my
> previous reply):
>=20
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

And from me to the same file (sound/soc/omap/mcbsp.c):

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>


- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
