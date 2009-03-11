From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] omapfb: Fix argument of blank 
	operation.
Date: Wed, 11 Mar 2009 22:47:41 +0530
Message-ID: <5d5443650903111017n9c818b0y2119d06ea84c3abf@mail.gmail.com>
References: <1228430755-4221-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1228430755-4221-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi Felipe,

On Fri, Dec 5, 2008 at 4:15 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> From: Felipe Contreras <felipe.contreras@nokia.com>
>
> The blank operation should receive FB_BLANK_POWERDOWN, not
> VESA_POWERDOWN.
>

Thanks. Looks good.

Signed-off-by: Trilok Soni <soni.trilok@gmail.com>


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
