From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Devices don't get linked to their class.
Date: Sun, 5 Sep 2004 18:40:27 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409051840.27452.adaplas@hotpop.com>
References: <1094187751.2979.41.camel@laptop.cunninghams> <200409042041.55199.adaplas@hotpop.com> <1094365292.6252.3.camel@laptop.cunninghams>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3uRX-0000wm-C4
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 03:40:19 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C3uRW-0004W5-Gk
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 03:40:19 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id EDE5E10C5D73
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  5 Sep 2004 10:40:01 +0000 (UTC)
In-Reply-To: <1094365292.6252.3.camel@laptop.cunninghams>
Content-Disposition: inline
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
To: ncunningham@linuxmail.org, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sunday 05 September 2004 14:21, Nigel Cunningham wrote:
> I'm only just beginning to learn how to use kobjects, so I'm not
> entirely sure. Looking more after posting that message, I began to think
> that struct class_device (going from memory) might act as equivalent to
> a linking table in a many-to-many relationship between classes and
> devices. If that's right, perhaps the right thing to do is leave the dev
> blank in the class registration and then register a class_device to link
> them when the actual driver registers.
>

Frankly, I don't know a thing about this stuff.  Just let me know what you
need and where you need them, and I'll see what I can do.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
