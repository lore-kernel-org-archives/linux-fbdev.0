From: Kronos <kronos@people.it>
Subject: Bug in fb_open()?
Date: Sat, 12 Jun 2004 16:50:23 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040612145023.GA3841@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BZ9q2-0004Rv-SA
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Jun 2004 07:50:30 -0700
Received: from mail-relay-2.tiscali.it ([212.123.84.92])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BZ9q2-0005I4-72
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Jun 2004 07:50:30 -0700
Received: from dreamland.darkstar.lan (82.84.178.199) by mail-relay-2.tiscali.it (7.0.028)
        id 40C460560033F322 for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Jun 2004 16:50:24 +0200
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi,
in fb_open (linux 2.6) there's the following code:

static int
fb_open(struct inode *inode, struct file *file) {
        ...
        if (!(info = registered_fb[fbidx]))
                return -ENODEV;
        if (!try_module_get(info->fbops->owner))
                return -ENODEV;
        ...
}

Now, what prevents a module from going away after the first check but
before the try_module_get? Since info is kmalloc()'ed and kfree()'ed by
the module we will dereference a dangling pointer, no?

struct file_operations is declared in fbmem.c, so the ->open (in
char_dev.c) won't affect module refcount.

IMHO it is wrong to put the 'owner' field in a structure owner by the
module since it can vanish at any time.

Am I missing something?

Luca
PS: yes, I'm still working on sysfs, but I'm very busy ATM.
-- 
Home: http://kronoz.cjb.net
Recursion n.:
	See Recursion.


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
