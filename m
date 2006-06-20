From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: porting fb driver to 2, 6(fb_get_fix,
	fb_get_var)
Date: Tue, 20 Jun 2006 22:25:38 +0800
Message-ID: <44980562.1010906@gmail.com>
References: <20060620120150.43888.qmail@web37914.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FshAu-0000uG-Jx for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 07:25:52 -0700
Received: from nz-out-0102.google.com ([64.233.162.195])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FshAt-0008EL-MB
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 07:25:52 -0700
Received: by nz-out-0102.google.com with SMTP id 13so1297114nzp
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jun 2006 07:25:51 -0700 (PDT)
In-Reply-To: <20060620120150.43888.qmail@web37914.mail.mud.yahoo.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

syed khader wrote:
> 
> --- "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> syed khader wrote:
>>> Hi,
>>>   I am trying to port one of our LCD display frame
>>> buffer driver to 2.6 kernel.
>>>   The old 2.4 kernel had these functions defined
>> in
>>> fb_ops
>>>     fb_open:    
>>>     fb_release:
>> These 2 are still in 2.6, but they're optional.
>>
>>>     fb_get_fix: 
>>>     fb_get_var:     
>> Gone.
> If they were gone do I have to just remove these
> functions in the older version of the driver and
> compile again. Will that suffice?

That, plus you need to add the functions that are
new in 2.6, as mentioned below.

>>>     fb_set_var: 
>> The above is split into:
>>
>> fb_check_var() - see if the requested var is
>> compatible
>>                  and if not, round up to the next
>>                  legal value
>>
>> fb_set_par()  - set the hardware based on the
>> current
>>                 var
>>>     fb_get_cmap:
>> gone
>>
>>>     fb_set_cmap:
>> replaced by fb_setcolreg()
>>
>>  
>>>     fb_ioctl:   
>> optional.
>>
>> Additional required ops for 2.6.
>>
>> fb_imageblit - expand monochrome to color and/or
>>                expand 8-bit pseudocolor to color
>>
>> Generic version for packed-pixel: cfb_imageblit
>>
>> fb_fillrect - fill rectangular area with solid color
>>
>> Generic version for packed-pixel: cfb_fillrect
>>
>>
>> fb_copyarea - copy rectangular area
>>
>> Generic version for packed-pixel: cfb_copyarea
>>
>>
>>>   But the latest 2.6 fb_ops has removed these and
>>> there is entirely new set of functions. 
>>>   I tried to go to list archives but I could not
>> find
>>> information. 
>>>   What functions in 2.6 fb_ops should to used to
>>> implement this old 2.4 set of functions?
>> Look at skeletonfb.c for comments.  The simplest
>> framebuffer driver you can start with is vfb.c
>>
>>
>> Tony
>>
>>
>   Another question: What happens to "struct display"
> being used in the older version.

It's gone.  It's now private to the framebuffer console
which you need not worry about.

Tony
