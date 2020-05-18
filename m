From: Andreas Schwab <schwab@linux-m68k.org>
Date: Mon, 18 May 2020 13:48:48 +0000
Subject: Re: [PATCH v2 2/2] powerpc/configs: replace deprecated riva/nvidia with nouveau
Message-Id: <87v9ktpd4v.fsf@igel.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200517220524.4036334-1-emil.l.velikov@gmail.com>
 <20200517220524.4036334-2-emil.l.velikov@gmail.com>
 <87d071aedu.fsf@mpe.ellerman.id.au>
In-Reply-To: <87d071aedu.fsf@mpe.ellerman.id.au> (Michael Ellerman's message
 of "Mon, 18 May 2020 17:30:53 +1000")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Emil Velikov <emil.l.velikov@gmail.com>, dri-devel@lists.freedesktop.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

On Mai 18 2020, Michael Ellerman wrote:

> The old drivers may be crufty but they presumably have been tested by
> people and at least somewhat work.

I can confirm that the nvidia fbdev driver is working perfectly fine.

> I gave it a quick spin on a G5 I have access to and dmesg has a bunch of
> errors in it (see below). I can't actually tell if the display is
> working because the machine is remote, and I can't go and check it at
> the moment because the office is closed.

The nouveau driver is completely borked.

[    2.299204] nouveau 0000:f0:10.0: NVIDIA NV34 (034100a2)
[    2.363100] nouveau 0000:f0:10.0: bios: version 04.34.20.19.00
[    2.363273] nouveau 0000:f0:10.0: bios: OOB 1 00000962 00000962
[    2.363323] nouveau 0000:f0:10.0: bios: OOB 1 00000966 00000966
[    2.363332] nouveau 0000:f0:10.0: bios: OOB 1 00000963 00000963
[    2.363341] nouveau 0000:f0:10.0: bios: OOB 1 00000964 00000964
[    2.363387] nouveau 0000:f0:10.0: bios: OOB 1 0000096a 0000096a
[    2.363396] nouveau 0000:f0:10.0: bios: OOB 1 00000967 00000967
[    2.363405] nouveau 0000:f0:10.0: bios: OOB 1 00000968 00000968
[    2.363453] nouveau 0000:f0:10.0: bios: OOB 1 0000096e 0000096e
[    2.363462] nouveau 0000:f0:10.0: bios: OOB 1 0000096b 0000096b
[    2.363471] nouveau 0000:f0:10.0: bios: OOB 1 0000096c 0000096c
[    2.363516] nouveau 0000:f0:10.0: bios: OOB 1 00000972 00000972
[    2.363526] nouveau 0000:f0:10.0: bios: OOB 1 0000096f 0000096f
[    2.363534] nouveau 0000:f0:10.0: bios: OOB 1 00000970 00000970
[    2.363580] nouveau 0000:f0:10.0: bios: OOB 1 00000976 00000976
[    2.363589] nouveau 0000:f0:10.0: bios: OOB 1 00000973 00000973
[    2.363597] nouveau 0000:f0:10.0: bios: OOB 1 00000974 00000974
[    2.363643] nouveau 0000:f0:10.0: bios: OOB 1 0000097a 0000097a
[    2.363652] nouveau 0000:f0:10.0: bios: OOB 1 00000977 00000977
[    2.363661] nouveau 0000:f0:10.0: bios: OOB 1 00000978 00000978
[    2.363709] nouveau 0000:f0:10.0: bios: OOB 1 0000097e 0000097e
[    2.363718] nouveau 0000:f0:10.0: bios: OOB 1 0000097b 0000097b
[    2.363727] nouveau 0000:f0:10.0: bios: OOB 1 0000097c 0000097c
[    2.363772] nouveau 0000:f0:10.0: bios: OOB 1 00000982 00000982
[    2.363781] nouveau 0000:f0:10.0: bios: OOB 1 0000097f 0000097f
[    2.363790] nouveau 0000:f0:10.0: bios: OOB 1 00000980 00000980
[    2.363836] nouveau 0000:f0:10.0: bios: OOB 1 00000986 00000986
[    2.363845] nouveau 0000:f0:10.0: bios: OOB 1 00000983 00000983
[    2.363854] nouveau 0000:f0:10.0: bios: OOB 1 00000984 00000984
[    2.363900] nouveau 0000:f0:10.0: bios: OOB 1 0000098a 0000098a
[    2.363909] nouveau 0000:f0:10.0: bios: OOB 1 00000987 00000987
[    2.363918] nouveau 0000:f0:10.0: bios: OOB 1 00000988 00000988
[    2.363965] nouveau 0000:f0:10.0: bios: OOB 1 0000098e 0000098e
[    2.363974] nouveau 0000:f0:10.0: bios: OOB 1 0000098b 0000098b
[    2.363983] nouveau 0000:f0:10.0: bios: OOB 1 0000098c 0000098c
[    2.364029] nouveau 0000:f0:10.0: bios: OOB 1 00000992 00000992
[    2.364038] nouveau 0000:f0:10.0: bios: OOB 1 0000098f 0000098f
[    2.364047] nouveau 0000:f0:10.0: bios: OOB 1 00000990 00000990
[    2.364383] nouveau 0000:f0:10.0: gpio: GPU is missing power, check its power cables.  Boot with nouveau.config=NvPowerChecks=0 to disable.
[    2.364402] nouveau 0000:f0:10.0: gpio: init failed, -22
[    2.364431] nouveau 0000:f0:10.0: init failed with -22
[    2.364438] nouveau: DRM-master:00000000:00000080: init failed with -22
[    2.364450] nouveau 0000:f0:10.0: DRM-master: Device allocation failed: -22
[    2.365268] nouveau: probe of 0000:f0:10.0 failed with error -22

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
