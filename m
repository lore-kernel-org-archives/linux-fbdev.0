From: Lubomir Rintel <lkundrak@v3.sk>
Date: Tue, 27 Nov 2018 13:24:23 +0000
Subject: Re: [PATCH] Fonts: New Terminus large console font
Message-Id: <374b76346ab53851632e8d300164022db9ed9a3c.camel@v3.sk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126034734.9423-1-amanoeladawod@gmail.com>
In-Reply-To: <20181126034734.9423-1-amanoeladawod@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nimrud <amanoeladawod@gmail.com>, gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi.

On Sun, 2018-11-25 at 22:47 -0500, nimrud wrote:
> This patch adds an option to compile-in a high resolution and large
> Terminus (ter16x32) bitmap console font for use with HiDPI and Retina screens.
> 
> The font was convereted from standard Terminus ter-i32b.psf (size 16x32)
> with the help of psftools and minor hand editing deleting useless characters.
> 
> This patch is non-intrusive, no options are enabled by default so most
> users won't notice a thing.
> 
> I am placing my changes under the GPL 2.0 just as source Terminus font.
> 
> Signed-off-by: Amanoel Dawod <amanoeladawod@gmail.com>

I've wished for a 15x30 font for quite some time, because that would
look good on an OLPC laptop screen that's 19cm (7.5") at 1200x900. A
15x30 would give me 80x30 characters, while a 16x32 would give me
somewhat less practical 75x28 with extra space around.

I'm wondering what resolutions are you targetting? Perhaps a 30x15
would do just as well, and if we need an 32x16, then we could perhaps
just add an ability to scale one of the existing fonts by a factor of
2.

Cheers
Lubo
