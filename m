From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: xxx_check_var
Date: 11 Dec 2002 00:13:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039562028.3373.32.camel@zion>
References: <15862.27978.670448.901111@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <15862.27978.670448.901111@argo.ozlabs.ibm.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Paul Mackerras <paulus@samba.org>
Cc: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, 2002-12-10 at 23:40, Paul Mackerras wrote:
> When I look at atyfb_check_var or aty128fb_check_var, I see that they
> will alter the contents of *info->par.  Isn't this a bad thing?  My

Yes, this wrong, and afaik, it's your original port to 2.5 that did that
;)

> understanding was that after calling check_var, you don't necessarily
> call set_par next (particularly if check_var returned an error).
> Also I notice that atyfb_set_par and aty128fb_set_par don't look at
> info->var, they simply set the hardware state based on the contents of
> *info->par.

Which is wrong too indeed

> Looking at skeletonfb.c, it seems that this is the wrong behaviour.  I
> had fixed the aty128fb.c driver in the linuxppc-2.5 tree.  James, if
> you let me know whether the current behaviour is wrong or not, I'll
> fix them and send you the patch.

I _think_ my radeonfb (in linuxppc-2.5) is right in this regard too.
Look at the initialization too, iirc, you had some non necessary stuff
in there (calling gen_set_disp, gen_set_var is plenty enough).

Ben.

 
> Paul.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
