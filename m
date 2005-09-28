From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: New driver: s3d2xfb
Date: Wed, 28 Sep 2005 21:16:06 +0800
Message-ID: <433A9796.7000505@gmail.com>
References: <433A746A.1070202@ums.usu.ru> <433A88A0.2080906@gmail.com> <8a0c3678050928055020971433@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKbnO-0003gP-Sb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 06:16:26 -0700
Received: from zproxy.gmail.com ([64.233.162.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EKbnO-00006C-Fb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 06:16:26 -0700
Received: by zproxy.gmail.com with SMTP id i11so558443nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Sep 2005 06:16:17 -0700 (PDT)
In-Reply-To: <8a0c3678050928055020971433@mail.gmail.com>
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
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>, Richard Smith <smithbone@gmail.com>

Richard Smith wrote:
>>>       if (!cnt) {
>>>               save_s3(info);
>>>       }
> 
>> You don't need to enclose a single statement with "curly braces".
> 
> I'm not trying to start any kind of flameage here but my curiosity was
> just tweaked by that statement.
> 
> What do you like about single line if's over ones with {} that leads
> you to advocate their usage?  You've obviously got loads of experience
> with a large amount of code written by other people so I'm interested
> in your opinion.

I don't really care which way, but it's the preferred, albeit,
undocumented kernel coding style.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
