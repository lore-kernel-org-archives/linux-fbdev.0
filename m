From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Linux-fbdev-devel] OLS and console rearchitecture
Date: Wed, 28 Jul 2004 17:23:01 -0700 (PDT)
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <20040729002301.50488.qmail@web14922.mail.yahoo.com>
References: <1091055478.31913.7.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <1091055478.31913.7.camel@localhost.localdomain>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kronos <kronos@people.it>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, DRI Devel <dri-devel@lists.sourceforge.net>

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > sysfs? I sent a patch a while ago but didn't get much feedback.
> 
> How do you atomically tie sysfs objects to fbdev and X permissions
> models ?

I think the plan here is for ROM export to be implemented by the PCI
driver not the video ones since other things besides video cards have
ROMs. For example some SCSI cards have a ROM so they can be boot
devices. Reading the ROM from sysfs will require root. But since all of
the hotplug events run in root context this is not a problem.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
--
