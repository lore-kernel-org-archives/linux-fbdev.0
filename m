From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Thu, 21 Oct 2004 12:36:59 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4177AD6B.23151.20F0292D@localhost>
References: <41764FB3.29782.1B9A13F4@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKikL-0008DL-Ar
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Oct 2004 12:37:13 -0700
Received: from mail.scitechsoft.com ([63.195.13.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CKikJ-00007w-3n
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Oct 2004 12:37:12 -0700
In-reply-to: <20041020191044.GB21315@elf.ucw.cz>
Content-description: Mail message body
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Pavel Machek <pavel@ucw.cz> wrote:

> One more question: Does 0xc0000 POST method work even on
> notebooks? On regular machines, PCI card must have normal bios and
> stuff is easy. On notebooks there was talk about "integrated bios"
> where it really has no video bios at all and system bios POSTs the
> card. Have you seen that? 

We have never had a need to POST a notebook Video BIOS so I don't know 
what would happen. It is an interesting question, and if this is to be 
used for resume operations something that should be investigated.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
