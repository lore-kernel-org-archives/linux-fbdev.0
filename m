From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: i810fb_blank
Date: Sat, 17 Dec 2005 03:10:06 +0800
Message-ID: <43A3110E.3040109@gmail.com>
References: <200512151614.44766.lucasvr@gobolinux.org> <200512160155.17019.lucasvr@gobolinux.org> <43A257E0.9030204@gmail.com> <200512161610.15048.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EnKyQ-0006bE-IP
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Dec 2005 11:10:34 -0800
Received: from zproxy.gmail.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EnKyO-0008FE-W7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Dec 2005 11:10:34 -0800
Received: by zproxy.gmail.com with SMTP id o1so741100nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Dec 2005 11:10:31 -0800 (PST)
In-Reply-To: <200512161610.15048.lucasvr@gobolinux.org>
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
To: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Lucas Correia Villa Real wrote:
> On Friday 16 December 2005 04:00, Antonino A. Daplas wrote:
>> I have neglected the suspend and resume hooks of i810fb so it's not
>> updated with the current code.  I don't have the hardware so I cannot
>> test.  Can you tell your friend to also try this patch if he cannot
>> solve the problem?
> 
> Hi Tony,
> 
> The patch worked fine for suspend, except for resume, which shows some weird 
> patterns on the screen. However, I'm not sure if this is i810fb's fault, 
> since i810fb_resume() isn't getting called at the time the resume hangs. 
> I'll dig a little bit into software suspend 2's resume operation, maybe 
> it's relying on something else which is broken.

You can try it first on a bare system.  No X, no DRM.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
