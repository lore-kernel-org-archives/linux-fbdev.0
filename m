From: Zachary Smith <plinius@comcast.net>
Subject: Re: Generic VESA framebuffer driver and Video
 card BOOT?
Date: Fri, 15 Oct 2004 11:55:24 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41701D1C.70705@comcast.net>
References: <416E6ADC.3007.294DF20D@localhost> <416FAF05.30267.1B66C92@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIXAq-0006rN-2E
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 11:51:32 -0700
Received: from sccrmhc11.comcast.net ([204.127.202.55])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CIXAo-0000oK-VV
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 11:51:31 -0700
In-Reply-To: <416FAF05.30267.1B66C92@localhost>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Kendall Bennett wrote:
> Zachary Smith <plinius@comcast.net> wrote:
> 
>>The problem of x86-only BIOSes is one of the videocard
>>manufacturers' own making which, in the spirit of good engineering,
>>they should fix before requiring a downstream kludge. 

 > Forgetting the fact that the BIOS image is x86, why
 > not think about the x86 BIOS image as being a set of 'generic'
 > instructions or p-code

Yes, this idea occurred to me after I posted my response.

But if you're going to add x86 emulation to the non-x86 kernels
perhaps it would be nice if you could find a way to permit
users to run x86 applications as well seamlessly.

Although that would introduce a tradeoff: kernel code should be
small which is bound to be slow in the case of an emulator,
which is OK for running BIOS code, but a user running apps
probably prefer optimized code which may be bigger.

On the other hand, a person running a free emulator doesn't
really have the option of great speed :)

Cheers,
Zack


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
