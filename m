From: Aivils Stoss <Aivils.Stoss@unibanka.lv>
Subject: Re: [BK console] console updates.
Date: Mon, 4 Nov 2002 11:40:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <OF15F84381.6ACA34E4-ONC2256C67.003460FB@unibanka.lv>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fri, 1 Nov 2002 09:40:05 -0800 (PST) James Simons wrote:
>> On Wed, Oct 30, 2002 at 01:56:38PM -0800, James Simmons wrote:
>> > I doubt this code will go into 2.5.X but it is avaiable for anyone to
play
>> > with it.
>>
>> Why?  I don't want to live another release with the old, crappy console,
>> and you've been working on this during almost all of 2.4 now..
>
>Give my console diff a try.
>
>http://phoenix.infradead.org/~jsimmons/console.diff.gz
>
>Its against 2.5.45. It has 3 bugs I know of.
>
>1) Switch back to X messes up the screen.

Already fixed in the linuxconsole 2.4.X backport http://startx.times.lv/

Aivils Stoss

--- linus-2.5/drivers/char/vt_ioctl.c    Mon Nov  4 11:33:57 2002
+++ linus-2.5/drivers/char/vt_ioctl.c.changed      Mon Nov  4 11:36:45 2002
@@ -1089,17 +1089,17 @@ int vt_ioctl(struct tty_struct *tty, str
                    if (!tmp) {
                         tmp = vc_allocate(vc->vt_newvt);
                         if (!tmp) {
                              i = vc->vt_newvt;
                              vc->vt_newvt = -1;
                              return i;
                         }
                    }
-
+                   vc->vt_newvt = -1;
                    /*
                     * When we actually do the console switch,
                     * make sure we are atomic with respect to
                     * other console switches..
                     */
                    acquire_console_sem();
                    complete_change_console(tmp,
vc->display_fg->fg_console);
                    release_console_sem();
