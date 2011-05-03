From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 03 May 2011 05:43:57 +0000
Subject: Re: [PATCH v6 3/6] video, sm501: add edid and commandline support
Message-Id: <BANLkTinH+dsW3MMxs_WfyxeE--HAQzhzLQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de> <1300782452-528-1-git-send-email-hs@denx.de>
 <1300782452-528-4-git-send-email-hs@denx.de> <20110502222716.GB15187@ponder.secretlab.ca>
 <BANLkTik3L28mmL=LGZ_0nV7vSOX9Miw3ow@mail.gmail.com> <4DBF922F.8040703@denx.de>
In-Reply-To: <4DBF922F.8040703@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: hs@denx.de
Cc: linuxppc-dev@lists.ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, Ben Dooks <ben@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, Wolfgang Denk <wd@denx.de>, Paul Mundt <lethal@linux-sh.org>

On Mon, May 2, 2011 at 11:27 PM, Heiko Schocher <hs@denx.de> wrote:
> Hello Grant,
>
> Grant Likely wrote:
>> On Mon, May 2, 2011 at 4:27 PM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>>> On Tue, Mar 22, 2011 at 09:27:29AM +0100, Heiko Schocher wrote:
>>>> - add commandline options:
>>>> =A0 sm501fb.mode:
>>>> =A0 =A0 Specify resolution as "<xres>x<yres>[-<bpp>][@<refresh>]"
>>>> =A0 sm501fb.bpp:
>>>> =A0 =A0 Specify bit-per-pixel if not specified mode
>>>>
>>>> - Add support for encoding display mode information
>>>> =A0 in the device tree using verbatim EDID block.
>>>>
>>>> =A0 If the "edid" entry in the "smi,sm501" node is present,
>>>> =A0 the driver will build mode database using EDID data
>>>> =A0 and allow setting the display modes from this database.
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>> Merged, thanks.
>>
>> This patch causes the following build warning:
>
> Hups ... when I posted the patch, it compiled clean ...
>
>> =A0 MODPOST vmlinux.o
>> WARNING: vmlinux.o(.text+0x1d5572): Section mismatch in reference from
>> the function sm501fb_init_fb() to the variable
>> .devinit.data:sm501_default_mode
>> The function sm501fb_init_fb() references
>> the variable __devinitdata sm501_default_mode.
>> This is often because sm501fb_init_fb lacks a __devinitdata
>> annotation or the annotation of sm501_default_mode is wrong.
>>
>> WARNING: vmlinux.o(.text+0x1d557a): Section mismatch in reference from
>> the function sm501fb_init_fb() to the variable
>> .devinit.data:sm501_default_mode
>> The function sm501fb_init_fb() references
>> the variable __devinitdata sm501_default_mode.
>> This is often because sm501fb_init_fb lacks a __devinitdata
>> annotation or the annotation of sm501_default_mode is wrong.
>>
>> I've dropped the __devinitdata declaration in what I committed; can
>> you investigate and post a fixup patch?
>
> Of course, I look ASAP at it, thanks!
> (Dummy question: where can I find your tree?)

git://git.secretlab.ca/git/linux-2.6 powerpc/next

g.

>
> bye,
> Heiko
> --
> DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
