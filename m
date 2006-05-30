From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: How to use ISRAm as a frame buffer in Linux
Date: Tue, 30 May 2006 20:33:47 +0800
Message-ID: <447C3BAB.70003@gmail.com>
References: <dbee5b5a0605300232r15a2c13dr4153bb39a2024411@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fl3Q9-0001K9-VU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 05:34:01 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fl3Q7-0000aB-MG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 05:34:02 -0700
Received: by py-out-1112.google.com with SMTP id b29so390391pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 30 May 2006 05:33:58 -0700 (PDT)
In-Reply-To: <dbee5b5a0605300232r15a2c13dr4153bb39a2024411@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: prakharv@gmail.com

Prakhar Vig wrote:
> Hi All,
>  
> I would like to read a Image data already present in the framebuffer, as
> I am new to this , I am finding it difficult to read. I have written one
> small application where I want to read Image pixels value which are
> present in Frame buffer.
>  

You can simply open and read /dev/fb0 and it will dump the framebuffer
in raw format.

cat /dev/fb0 will also do the trick.

Google for a screenshot program for the framebuffer. fbgrab is an example.

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
