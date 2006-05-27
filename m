From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Twister savagefb doesn't sync
Date: Sat, 27 May 2006 17:29:31 +0800
Message-ID: <44781BFB.5020708@gmail.com>
References: <44698356.80806@iit.demokritos.gr> <447359B8.7020304@iit.demokritos.gr> <447381E9.4060705@gmail.com> <447803FC.8050009@iit.demokritos.gr> <44781B3A.5030406@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fjv78-0001tz-90
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 02:29:42 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fjv78-0003e2-2G
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 02:29:42 -0700
Received: by py-out-1112.google.com with SMTP id b29so78247pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 May 2006 02:29:40 -0700 (PDT)
In-Reply-To: <44781B3A.5030406@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: vasvir@iit.demokritos.gr, linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:
> Vassilis Virvilis wrote:
>> Antonino A. Daplas wrote:
>>
>>> If you can somehow dump the registers of the working and non-working
>>> mode,
>>> we might be able find a pattern.
>>>
>>> If you don't know how to dump the register contents, let me know and I'll
>>> send you a userspace utility to do that.
>>>
>>>
>> I found dumpreg from the svgalib distribution (svgalib-bin in debian).
>> Is this
>> sufficient? 
> 
> It might not be sufficient as it won't be able to recognize savage extended
> VGA registers.
> 
>> If not could you please send me the userspace utility you
>> mentioned
>> the other day?
>>
> 
> Ok, attached, it's a quick hack. Before using it open the file savagedump.c 
> and look for the following defines:
> 
> #define PCI_ID        0x8d04  /* put the PCI id of the device here */
> #define PCI_PBASE     0xdfe80000  /* put the start address of the PCI resource here */
> 
> and replace the above values with your own. First do "lspci -n | grep "Class 0300"
> and you'll get something like this:
> 
> 01:00.0 Class 0300: 5333:8d04
> 
> Use the last 4 digit ID for the PCI_ID (ie 8d04):
> 
> Then do lspci -v -n 5333:8d04 (using instead the vendor:device that you got) and you

Typo.  I meant

lspci -v -d 5333:8d04

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
