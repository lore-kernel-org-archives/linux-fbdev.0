From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Generic VESA framebuffer driver and Video
 card BOOT?
Date: Mon, 18 Oct 2004 15:34:58 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <417428F2.2050402@bitworks.com>
References: <200410160946.32644.adaplas@hotpop.com> <4173B865.26539.117B09BD@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJeDi-0003oq-2Q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 13:35:06 -0700
Received: from [69.4.201.55] (helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJeDg-0000mj-KJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 13:35:05 -0700
In-Reply-To: <4173B865.26539.117B09BD@localhost>
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
Cc: linux-kernel@vger.kernel.org

Kendall Bennett wrote:

> 
> I would assume however a serial port console would be fine for embedded 
> machines until the framebuffer driver could come up anyway.
> 
This would be an incorrect assumption.  Speaking as a developer of one 
said embedded system I must have video at boot and be able to dump 
critical kernel messages to the screen.

In the field, hooking up a serial cable to see why the unit doesn't boot 
requires the dispatch of a tech who would have open up the unit to get 
to the serial port.  This costs the end client lots of $$.  They don't 
like that.

By having video on boot the support person can tell the end user to look 
at the screen and read back any messages and then make the determination 
  if a tech dispatch is needed.

And its common practice to only have as many serial ports as the system 
needs during runtime.  During development you can dual purpose them but 
in the final system their may not be a serial port free (or even 
installed) to get that console info from.

-- 
Richard A. Smith




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
