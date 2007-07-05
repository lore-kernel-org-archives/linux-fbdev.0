From: "Ryan Hope" <rmh3093@gmail.com>
Subject: Re: [PATCH v2 0/5] uvesafb: a general
	description
Date: Thu, 5 Jul 2007 13:38:46 -0400
Message-ID: <48f7fe350707051038p422ea305w10d727bcc44e5d7b@mail.gmail.com>
References: <20070630163101.GA3838@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1866838527=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I6VI2-0000HE-3X for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jul 2007 10:38:50 -0700
Received: from nz-out-0506.google.com ([64.233.162.228])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I6VHz-00032v-LV
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jul 2007 10:38:49 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1721636nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 05 Jul 2007 10:38:47 -0700 (PDT)
In-Reply-To: <20070630163101.GA3838@spock.one.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: spock@gentoo.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, hpa@zytor.com

--===============1866838527==
Content-Type: multipart/alternative; 
	boundary="----=_Part_150960_23537465.1183657126274"

------=_Part_150960_23537465.1183657126274
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I applied
http://dev.gentoo.org/~spock/projects/uvesafb/archive/uvesafb-0.1-rc2-2.6.22-rc6.patchto
2.6.22-rc6-mm1... everything seems to be working properly. However, in dmesg
I did notice the following message:

uvesafb: message too long (9872), can't execute task
uvesafb: VBE get state call failed (eax=0x4f04, err=-7)

The messages seem to get generated when I switch VTs. Just thought I would
let you know. If there is anything else I can do to help let me know.

-Ryan

On 6/30/07, Michal Januszewski <spock@gentoo.org> wrote:
>
> uvesafb is a generic driver for VBE2+ compliant video cards; an enhanced
> version of vesafb and a direct successor of vesafb-tng [1].
>
> This is the second version of this patch, and it incorporates all fixes
> and cleanups suggested on the lkml.  My thanks to everyone who took
> their time to review the first version.
>
> uvesafb uses a userspace helper application (v86d, [2]) to run the x86
> Video BIOS code.  This makes it possible to include in uvesafb all the
> standard features (refresh rate control, video mode changes etc) that
> are missing from vesafb without resorting to ugly hacks such as the ones
> used in [1].  The current implementation of v86d can use either LRMI or
> x86emu to run the BIOS code and supports both x86 and x86_64.
>
> [1] http://dev.gentoo.org/~spock/projects/vesafb-tng/
> [2] http://dev.gentoo.org/~spock/projects/uvesafb/
>
> Best regards.
> --
> Michal Januszewski                              JID: spock@im.gentoo.org
> Gentoo Linux Developer                    http://people.gentoo.org/spock
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

------=_Part_150960_23537465.1183657126274
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I applied <a href="http://dev.gentoo.org/~spock/projects/uvesafb/archive/uvesafb-0.1-rc2-2.6.22-rc6.patch">http://dev.gentoo.org/~spock/projects/uvesafb/archive/uvesafb-0.1-rc2-2.6.22-rc6.patch</a> to 2.6.22-rc6-mm1... everything seems to be working properly. However, in dmesg I did notice the following message:
<br><br>uvesafb: message too long (9872), can&#39;t execute task<br>uvesafb: VBE get state call failed (eax=0x4f04, err=-7)<br><br>The messages seem to get generated when I switch VTs. Just thought I would let you know. If there is anything else I can do to help let me know.
<br><br>-Ryan<br><br><div><span class="gmail_quote">On 6/30/07, <b class="gmail_sendername">Michal Januszewski</b> &lt;<a href="mailto:spock@gentoo.org">spock@gentoo.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
uvesafb is a generic driver for VBE2+ compliant video cards; an enhanced<br>version of vesafb and a direct successor of vesafb-tng [1].<br><br>This is the second version of this patch, and it incorporates all fixes<br>and cleanups suggested on the lkml.&nbsp;&nbsp;My thanks to everyone who took
<br>their time to review the first version.<br><br>uvesafb uses a userspace helper application (v86d, [2]) to run the x86<br>Video BIOS code.&nbsp;&nbsp;This makes it possible to include in uvesafb all the<br>standard features (refresh rate control, video mode changes etc) that
<br>are missing from vesafb without resorting to ugly hacks such as the ones<br>used in [1].&nbsp;&nbsp;The current implementation of v86d can use either LRMI or<br>x86emu to run the BIOS code and supports both x86 and x86_64.<br><br>
[1] <a href="http://dev.gentoo.org/~spock/projects/vesafb-tng/">http://dev.gentoo.org/~spock/projects/vesafb-tng/</a><br>[2] <a href="http://dev.gentoo.org/~spock/projects/uvesafb/">http://dev.gentoo.org/~spock/projects/uvesafb/
</a><br><br>Best regards.<br>--<br>Michal Januszewski&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;JID: <a href="mailto:spock@im.gentoo.org">spock@im.gentoo.org</a><br>Gentoo Linux Developer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://people.gentoo.org/spock">
http://people.gentoo.org/spock</a><br><br>-<br>To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel&quot; in<br>the body of a message to <a href="mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org
</a><br>More majordomo info at&nbsp;&nbsp;<a href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>Please read the FAQ at&nbsp;&nbsp;<a href="http://www.tux.org/lkml/">http://www.tux.org/lkml/</a>
<br></blockquote></div><br>

------=_Part_150960_23537465.1183657126274--


--===============1866838527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1866838527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1866838527==--
