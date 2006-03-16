From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] add modeline for 1680x1050@60
Date: Thu, 16 Mar 2006 09:32:11 +0800
Message-ID: <4418C01B.6070500@gmail.com>
References: <20060313123502.GA5996@suse.de> <4415DB74.5040203@gmail.com> <20060314101706.GA15227@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJiM9-0007Xn-8G
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Mar 2006 18:36:53 -0800
Received: from pproxy.gmail.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FJiM7-0003Ey-3E
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Mar 2006 18:36:53 -0800
Received: by pproxy.gmail.com with SMTP id z59so278440pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Mar 2006 18:36:16 -0800 (PST)
In-Reply-To: <20060314101706.GA15227@suse.de>
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
To: Olaf Hering <olh@suse.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

Olaf Hering wrote:
>  On Tue, Mar 14, Antonino A. Daplas wrote:
> 
>> Olaf Hering wrote:
>>> Add a modeline for the Philips 200W display. 
>>> aty128fb does not do DDC, it picks 1920x1440 or similar.
>>> It works ok with nvidiafb because it can ask for DDC data.
>> What happens if you use something like
>>
>> video=atyfb:1680x1050M@60; or
>> video=atyfb:1680x1050MR@60
> 
> It still switches to 1900x1200@60
> 

Okay.

Acked-by: Antonino Daplas <adaplas@pol.net>

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
