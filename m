From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 22 Oct 2004 10:16:23 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <88056F38E9E48644A0F562A38C64FB6003287D18@scsmsx403.amr.corp.intel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL32E-0003XV-Vk
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 10:17:02 -0700
Received: from fmr05.intel.com ([134.134.136.6] helo=hermes.jf.intel.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CL32E-0005AU-Dn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 10:17:02 -0700
Content-class: urn:content-classes:message
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
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

=20

>-----Original Message-----
>From: Kendall Bennett [mailto:KendallB@scitechsoft.com]=20
>Sent: Friday, October 22, 2004 10:11 AM
>To: Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org;=20
>linux-fbdev-devel@lists.sourceforge.net
>Subject: RE: [Linux-fbdev-devel] Re: Generic VESA framebuffer=20
>driver and Video card BOOT?
>
>"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:
>
>> I have done some experiments with this video post stuff. I think
>> this should be done using x86 emulator rather than doing in real
>> mode. The reason being, with an userlevel emulator we can call it
>> at different times during resume. The current real mode videopost
>> does it before the driver has restored the PCI config space. Some
>> systems (mostly the ones with Radeon card) requires this to be
>> done after PCI config space is restored. With a userspace
>> emulator, we can call it at various places during the driver
>> restore.=20
>>=20
>> I have seen the SciTech's x86 emulator in X.org. I could seperate
>> it out from X into a stand alone application that does x86
>> emulation. I use it to get the video back on my laptop (which has
>> radeon card), by calling this user level emulator using
>> usermodehelper call. I hope we will have x86 emulator sitting in a
>> standard place in userspace. That way we can use it in driver
>> restore and solve the S3 video restore problem in a more generic
>> way.=20
>
>We already have all this code completely separate from X and would=20
>release this as part of the Video Boot package for Linux. The kernel=20
>module is one part of it, but the code can be compiled as a=20
>stand alone=20
>user land program as well (SNAPBoot we call it right now).=20
>

That is really nice to know. That will make "video on S3 resume" problem
go away on quite a few laptops. Will look forward to release of such a
code.

Thanks,
Venki


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
