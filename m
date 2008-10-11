From: "Michal Januszewski" <michalj@gmail.com>
Subject: Re: [Bugme-new] [Bug 11734] New: Ramdonly linux
	don't boot,
	it hangs at the very first stage of booting with some error related
	with uvesafb
Date: Sat, 11 Oct 2008 11:38:00 +0200
Message-ID: <5d9b736f0810110238v6290ec5dm8d1621edaa99c12e@mail.gmail.com>
References: <bug-11734-10286@http.bugzilla.kernel.org/>
	<20081010135045.8b4772f5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michalj@gmail.com>) id 1KoazO-0006iO-Pl
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Oct 2008 09:42:22 +0000
Received: from wf-out-1314.google.com ([209.85.200.175])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KoavC-0003Vi-LT for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Oct 2008 09:42:22 +0000
Received: by wf-out-1314.google.com with SMTP id 27so912371wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 11 Oct 2008 02:38:00 -0700 (PDT)
In-Reply-To: <20081010135045.8b4772f5.akpm@linux-foundation.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: diegoocampo8@gmail.com, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

On Fri, Oct 10, 2008 at 22:50, Andrew Morton <akpm@linux-foundation.org> wrote:

>> I am not sure if it is related with Ubuntu or with the kernel but the problems
>> take place in the very first stage of booting (maybe with the loading of the
>> kernel??) and I get the following error messages:
>> "606627 uvesafb: failed to execute /sbin/v86d"
>> "606719 uvesafb: make sure that the v86d helper is installed and executable"
>> "606814 uvesafb: Getting VBE info block failed (eax=0x4f00, err=-2)"
>> "606905 uvesafb: vbe_init() failed with -22
>
>> Like i said this is a ramdonly problem,if i restart the computer most probably
>> ubuntu starts, but i think it is very annoying anyway!.

Do you have these uvesafb error messages in the kernel log (run `dmesg`
to check the kernel log) when your laptop boots successfully?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
