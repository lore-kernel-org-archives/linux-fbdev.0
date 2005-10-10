From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: DRM & MTRR's
Date: Tue, 11 Oct 2005 06:06:16 +0800
Message-ID: <434AE5D8.3020806@gmail.com>
References: <1127475052.9377.18.camel@jetpack.demon.co.uk>	 <43340C3E.5070005@gmail.com> <1128974307.9450.66.camel@jetpack.demon.co.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EP5ml-0005kG-Og
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Oct 2005 15:06:19 -0700
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EP5mz-00056A-UK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Oct 2005 15:06:34 -0700
Received: by zproxy.gmail.com with SMTP id 14so853744nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 10 Oct 2005 15:06:20 -0700 (PDT)
In-Reply-To: <1128974307.9450.66.camel@jetpack.demon.co.uk>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Alan Hourihane <alanh@fairlite.demon.co.uk>
Cc: dri-devel@lists.sf.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Alan Hourihane wrote:
> On Fri, 2005-09-23 at 22:07 +0800, Antonino A. Daplas wrote:
>> Alan Hourihane wrote:
>>> Has anyone any objections to me removing the MTRR code from the DRM.
>>>
>>> It doesn't have the intimate knowledge needed to properly configure
>>> MTRR's and fails in many cases.
>>>
>>> There are two cases currently, one for the framebuffer and a second for
>>> the entire AGP space.
>>>
>>> Certainly in Intel hardware this is the same memory space and you always
>>> get bogus error messages in your kernel logs as things fail due to lack
>>> of boundary checks.
>>>
>>> I'm more of the opinion that it should be left up to userspace to
>>> configure MTRR's if it indeed wants them and we shouldn't force them
>>> within the DRM.
>>>
>>> Additionally, the Xserver (for user-space) already sets up the MTRR's,
>>> as should Xgl (Xegl) or other user space apps.
>>>
>>> What makes the situation a little worse is that vesafb (and other *fb
>>> drivers) also setup an mtrr which frequently stops subsequent processes
>>> from adding a new one that overlaps an existing write-combining range.
>>> But the *fb drivers do provide a nomtrr option in many cases. (But I'd
>>> like to remove it from them too :-) or at least default those to off)
>> I don't know the repercussions of defaulting to nomtrr. But I would
>> surmise that a large percentage of users gives more importance to X/DRI
>> performance than console performance (majority of vesafb users still
>> use redraw for scrolling where ypan is magnitudes faster, so I'm pretty
>> sure defaulting vesafb to nomtrr will not be noticeable to most users,
>> they probably go straight to X anyway :-)
>>
>> I cannot decide on this alone, so I'm going to CC the fbdev-devel list.
>> Perhaps I can submit a patch that defaults all drivers to nomtrr and a
>> big warning about mtrr not being set in dmesg. If I don't get any
>> backlash for a few patch cycles, I can make this permanent.
> 
> Tony,
> 
> What was the outcome of this in kernel land ??

No one responded :-(.  But I'll try to get a patch to the mm tree
disabling the mtrr's.  

> 
> Just to give you an idea of why it really causes problems.
> 
> If you are using vesafb and it sets up it's own mtrr for usually the
> first 4MB of the framebuffer. Now, X will fail to set it's MTRR. And
> thus the first 4MB remains write-combined.

Yes, I know the problem.  vesafb does attempt to type range the entire
aperture (which is different from the the actual memory vesafb uses),
but the Video BIOS usually gets it wrong (the actual aperture size). 

> 
> Running the isosurf benchmark from Mesa, shows only 300fps. Yet, doing
> echo "disable=3" > /proc/mtrr to remove that vesafb mtrr and allows X to
> setup the full range results in isosurf jumping to 650fps.
> 
> Defaulting vesafb (and the others) to nomtrr which save us this pain.

Okay.

Tony



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
