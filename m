From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 3/4] suspend: Documentation update for IBM Thinkpad X30
Date: Sun, 23 Apr 2006 08:31:30 +0800
Message-ID: <444ACAE2.1070909@gmail.com>
References: <444999D8.6090104@gmail.com> <20060422090116.GE3590@elf.ucw.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FXSxX-0005qj-S2
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 22 Apr 2006 18:00:19 -0700
Received: from pproxy.gmail.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FXSxS-0000JC-BG
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 22 Apr 2006 18:00:18 -0700
Received: by pproxy.gmail.com with SMTP id i49so808480pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 22 Apr 2006 18:00:04 -0700 (PDT)
In-Reply-To: <20060422090116.GE3590@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Pavel Machek wrote:
> On So 22-04-06 10:50:00, Antonino A. Daplas wrote:
>> As reported in Bugzilla Bug 6406, resume from S3 results in a blank
>> screen.
>>
>> For the IBM Thinkpad X30 using vesafb as the console driver, successful
>> resume from S3 requires option acpi_sleep=s3_bios,s3_mode.  Update
>> documentation.
>>
>> I would presume that, in any hardware, using vesafb as the console driver will
>> require as a minimum s3_mode.
> 
> Well, some hardware just preserves video state, but you are right that
> anything that needs s3_bios probably needs s3_mode, too.

For vgacon, s3_bios may be the only option needed since POSTING automatically goes
to text mode. For vesafb, s3_mode, in most cases, will also required.

> 
> Do you think you could try code from suspend.sf.net and fix whitelist
> there?

I'll try, although in-kernel suspend works for me properly.

Tony


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
