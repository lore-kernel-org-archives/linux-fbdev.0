From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] better error handing in savagefb_probe
Date: Tue, 30 Aug 2005 09:09:13 +0800
Message-ID: <4313B1B9.7040006@gmail.com>
References: <20050829194228.GA16954@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9udA-0007L3-KY
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Aug 2005 18:09:40 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E9ud8-00016I-9z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Aug 2005 18:09:40 -0700
Received: by wproxy.gmail.com with SMTP id i31so602082wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 Aug 2005 18:09:31 -0700 (PDT)
In-Reply-To: <20050829194228.GA16954@suse.de>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Olaf Hering <olh@suse.de>

Olaf Hering wrote:
> err remains uninitialized of pci_request_regions fails.
> 
> Found by Thorsten Kukuk, I added a few more checks.
> 
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

Thanks, I've added this to my tree. I'll push this to Andrew
on my next patch drop.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
