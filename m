From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 19 Dec 2013 18:55:17 +0000
Subject: Re: [PATCH v3] x86: sysfb: remove sysfb when probing real hw
Message-Id: <20131219185517.GA303@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387374611-12493-1-git-send-email-dh.herrmann@gmail.com>
 <1387448038-8260-1-git-send-email-dh.herrmann@gmail.com>
 <52B340CB.90807@wwwdotorg.org>
In-Reply-To: <52B340CB.90807@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, the arch/x86 maintainers <x86@kernel.org>, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, stable@vger.kernel.org


* Stephen Warren <swarren@wwwdotorg.org> wrote:

> On 12/19/2013 03:13 AM, David Herrmann wrote:
> > With CONFIG_X86_SYSFB=y, probing real hw-drivers may result in
> > resource-conflicts and drivers will refuse to load. A call to
> > request_mem_region() will fail, if the region overlaps with the mem-region
> > used by simplefb. The common desktop DRM drivers (intel, nouveau, radeon)
> > are not affected as they don't reserve their resources, but some others
> > do, including (nvidiafb, cirrus, ..).
> 
> I have validated that this doesn't cause any regressions on the/a
> non-x86 platform using simplefb, although given the main point of this
> patch is to fix issues on x86, I'm rather hesitant to give a tested-by
> tag in case someone looking back interprets it incorrectly:-)

Tested-on-ARM-by: Stephen Warren <swarren@wwwdotorg.org>

?

Thanks,

	Ingo
