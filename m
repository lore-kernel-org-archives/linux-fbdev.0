From: Manuel =?ISO-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Date: Wed, 23 Nov 2016 17:21:56 +0000
Subject: Re: [PATCH v6 2/2] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1479921716.5446.4.camel@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479832909-19646-1-git-send-email-manuel.schoelling@gmx.de>
         <1479832909-19646-3-git-send-email-manuel.schoelling@gmx.de>
         <20161122193143.GG11418@dell-m4800.home>
In-Reply-To: <20161122193143.GG11418@dell-m4800.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Di, 2016-11-22 at 19:31 +0000, Andrey Utkin wrote:
> I'm not sure my emails with review of previous submission reached you, but in
> them I meant to mention that there are some style nits which are easy to
> eliminate.
I am afraid I did not get it. I will fix these style issues in the next
patch: Adam Borowski found another issue with clearing the scrollback
buffer, which I am finally able to reproduce.

> P. S. Manuel, please fix your git-send-email workflow or apply some
> workaround (check locale settings and such). Again your References
> header contains illegal symbol:
> 
> References: <201611210615.PPE1zXiO??ngguang.wu@intel.com>
I finally found out where the issue came from: Evolution somehow
reinterprets the Message-Id when you are copying it to the clipboard.

