From: Jordan Benjamin <jordanb@caltech.edu>
Subject: Re: radeonfb & fbdev code status
Date: Sat, 15 Nov 2003 23:17:29 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <EFF3F4D4-1804-11D8-A894-0003931DDB42@caltech.edu>
References: <70AC3EE8-17AD-11D8-A894-0003931DDB42@caltech.edu> <1068959152.5157.50.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALHAm-0000Ne-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 23:18:16 -0800
Received: from steelemr-loadb-nat-49.caltech.edu ([131.215.49.69])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ALHA7-0000XC-JW
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Nov 2003 23:17:35 -0800
In-Reply-To: <1068959152.5157.50.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: benh@kernel.crashing.org
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Thanks for a very informative reply. My only other question now is: 
where can I find the current radeonfb code? I apologize if this should 
be obvious to me (I do have an excuse though--I'm recovering from 
throat surgery and on a lot of painkillers!). Thanks,

Jordan


On Nov 15, 2003, at 9:05 PM, Benjamin Herrenschmidt wrote:
> You should be able to get most of this with the new radeonfb (let me
> know if that doesn't work), _except_ maybe the suspend/resume. What
> happens on x86 laptops regarding suspend/resume is not very clear,
> depending on if you are doing ACPI or APM suspend for example, and
> in some case, the only solution is to actually reboot the chip from
> scratch, which we cannot do, at least not with the current scheme.
>
> Since it works with vesafb, I suppose your BIOS is taking care of
> restoring the chip, so the problem may either be the radeonfb resume
> code not properly restoring its own graphic setup, or the BIOS beeing
> shoked by some of the settings changes done by radeonfb. It may be
> worth trying to restore the initial state of the chip when suspending,
> I'll investigate that.
>
> First, try to get the new driver working and let me know of any
> problem beside suspend/resume. Then, we'll see if we can get something
> working for suspend/resume as well.




-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
