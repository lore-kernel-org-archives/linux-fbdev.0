From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] fb: add support for handoff from
	firmware to hw framebuffers (v2)
Date: Sat, 6 Jun 2009 11:38:32 +1000
Message-ID: <21d7e9970906051838g2058a651x8be7786c6b6237f4@mail.gmail.com>
References: <1244182034-9742-1-git-send-email-airlied@gmail.com>
	<4A2922E7.7030806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <airlied@gmail.com>) id 1MClHB-0006kE-Ha
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Jun 2009 02:04:53 +0000
Received: from mail-gx0-f218.google.com ([209.85.217.218])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MClHA-00008F-Ho for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Jun 2009 02:04:53 +0000
In-Reply-To: <4A2922E7.7030806@redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Peter Jones <pjones@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sf.net

On Fri, Jun 5, 2009 at 11:51 PM, Peter Jones<pjones@redhat.com> wrote:
> On 06/05/2009 02:07 AM, Dave Airlie wrote:
>> From: Dave Airlie <airlied@redhat.com>
>>
>> With KMS we have ran into an issue where we really want the KMS fb driver
>> to be the one running the console, so panics etc can be shown by switching
>> out of X etc.
>>
>> However with vesafb/efifb built-in, we end up with those on fb0 and the
>> KMS fb driver on fb1, driving the same piece of hw, so this adds an fb info
>> flag to denote a firmware fbdev, and adds a new aperture base/size range
>> which can be compared when the hw drivers are installed to see if there
>> is a conflict with a firmware driver, and if there is the firmware driver is
>> unregistered and the hw driver takes over.
>>
>> It uses new aperture_base/size members instead of comparing on the fix
>> smem_start/length, as smem_start/length might for example only cover the
>> first 1MB of the PCI aperture, and we could allocate the kms fb from 8MB
>> into the aperture, thus they would never overlap.
>>
>> v2: add an fb_destroy callback so the firmware fb can cleanup after itself.
>> vesafb will now remove the region it reserves and destroy its fb info.
>>
>> Signed-off-by: Dave Airlie <airlied@redhat.com>
>
> This version looks good to me.
>
> Acked-by: Peter Jones <pjones@redhat.com>
>

Andrew do we have an fbdev maintainer or can you pick this up for the
next merge window?

Dave.

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
