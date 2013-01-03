From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 03 Jan 2013 15:12:23 +0000
Subject: Re: 3.8-rc2: EFI framebuffer lock inversion...
Message-Id: <CA+icZUV-rgfmNRK+RAGRywRhzyV4-z+s4yB0+xW4WHUjScdjyg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMVG2ssA-B6s+F-g4mL0dbBSVsNupzT1nm1Kc70dXHGsNQuNYA@mail.gmail.com>
In-Reply-To: <CAMVG2ssA-B6s+F-g4mL0dbBSVsNupzT1nm1Kc70dXHGsNQuNYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>

Hi,

I have tested the fb-fix [1] from Alan on top of Linux v3.8-rc2.

Unfortunately, several people still complain about it.
As Boris shouted out... Apply directly to mainline?

Feel free to add a "Tested-by".

Just FYI: There seems to exist a locking problem with efifb reported
by Daniel J (also see [1]).

Regards,
- Sedat -

[1] http://marc.info/?t5721787600001&r=1&w=2
[2] https://patchwork.kernel.org/patch/1757061/
