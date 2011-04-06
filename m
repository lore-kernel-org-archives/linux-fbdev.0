From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Apr 2011 16:50:16 +0000
Subject: Re: [PATCH 1/2] savagefb: Replace magic register address with define
Message-Id: <20110406165006.GE11820@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301835246-6520-1-git-send-email-lists.tormod@gmail.com>
In-Reply-To: <1301835246-6520-1-git-send-email-lists.tormod@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, Apr 03, 2011 at 02:54:04PM +0200, Tormod Volden wrote:
> MM_SERIAL1 was already defined, but not used.
> 
> Signed-off-by: Tormod Volden <debian.tormod@gmail.com>

On Sun, Apr 03, 2011 at 02:54:05PM +0200, Tormod Volden wrote:
> In practice this means enabling I2C (for DDC2) on all prosavage cards,
> like the xorg ddx does. The savage4 and savage2000 families have only
> one member each, so there is no change for those.
> 
> Tested on TwisterK.
> 
> Signed-off-by: Tormod Volden <debian.tormod@gmail.com>

On Sun, Apr 03, 2011 at 02:54:06PM +0200, Tormod Volden wrote:
> The else clause was not needed after the cleanup in commit
> b8901b091db260b0f0101d6395ce5c6016835a47
> 
> Signed-off-by: Tormod Volden <debian.tormod@gmail.com>

These all look fine. All applied, thanks.
