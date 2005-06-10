From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: lost console font setting
Date: Fri, 10 Jun 2005 10:32:21 -0400
Message-ID: <9e47339105061007323956ab83@mail.gmail.com>
References: <9e47339105061007013f1984de@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgkYf-0005mT-9O
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 07:32:29 -0700
Received: from wproxy.gmail.com ([64.233.184.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DgkYd-0003y5-Rt
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 07:32:29 -0700
Received: by wproxy.gmail.com with SMTP id 55so1043830wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jun 2005 07:32:21 -0700 (PDT)
In-Reply-To: <9e47339105061007013f1984de@mail.gmail.com>
Content-Disposition: inline
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On 6/10/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> On the x86 if I load radeonfb the VGA console loses it font.  Runing
> setfont or switching to X and back restores the font. How is the VGA
> font controlled, what needs to be change in radeonfb to stop it from
> stomping the VGA font? This is all in text mode, fbconsole is not
> running.

I found the source of this. radeonfb memsets VRAM to zero at load.
That sets all the chars in the VGA font table to zero which makes the
console disappear.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
