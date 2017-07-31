From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 31 Jul 2017 19:13:32 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <487000e3-afeb-0e59-c563-0ef4b1347d8d@zytor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com>
 <20170718143404.omgxrujngj2rhiya@redhat.com>
 <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
 <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
In-Reply-To: <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>

On 07/18/17 13:44, Dave Airlie wrote:
> 
> In normal operation the console is faster with _wc. It's the side effects
> on other cores that is the problem.
> 

I'm guessing leaving these as UC- rate-limits them so it doesn't
interfere with the I/O operations on the other cores...

	-hpa

