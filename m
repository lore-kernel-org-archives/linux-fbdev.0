From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] drivers/video/imsttfb.c: setclkMHz: clk_p
 is always 0
Date: Sat, 07 Jan 2006 09:34:25 +0800
Message-ID: <43BF1AA1.8000702@gmail.com>
References: <20060106162554.GJ12131@stusta.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161115AbWAHAzO@vger.kernel.org>
In-Reply-To: <20060106162554.GJ12131@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The Coverity checker noticed that in the function setclkMHz in 
> drivers/video/imsttfb.c, the variable clk_p is never assigned a value 
> other than 0.
> 
> Could someone understanding this code decide whether this is a real bug 
> or whether clk_p can be replaced by 0?
> 

It does look like to be an oversight.  The same is present in Xorg code
too.

Tony
