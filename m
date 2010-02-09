From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 09 Feb 2010 21:41:51 +0000
Subject: Re: i810fb: Breaks EDID for Xorg
Message-Id: <20100209134151.9ee5d4f4.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <be7a9f3d1002080536v4c38f6e7k492fd09fdab72b5a@mail.gmail.com>
In-Reply-To: <be7a9f3d1002080536v4c38f6e7k492fd09fdab72b5a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Otavio Salvador <otavio@ossystems.com.br>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

(cc linux-fbdev-devel)

On Mon, 8 Feb 2010 11:36:39 -0200
Otavio Salvador <otavio@ossystems.com.br> wrote:

> Hello,
> 
> After some time looking for why one system had EDID working, for Xorg,
> and other don't I found the reason being CONFIG_FB_I810.
> 
> When I enable CONFIG_FB_I810 the Xorg VBE reading fails; if I disable
> it, it works fine.
> 
> Anyone has any idea how to fix it?
> 

