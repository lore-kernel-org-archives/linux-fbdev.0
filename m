From: "Peter Hanzel" <hanzelpeter@gmail.com>
Subject: DRM KMS + intel fb
Date: Thu, 23 Apr 2009 12:12:15 +0200
Message-ID: <7398C9BACDA74507AA9FCCCE4847C5A4@avitech.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755075AbZDWKMG@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello.

I am watching the KMS in DRM development. And now i want to try kernel 
modesetting with framebuffer console.
I am only using console framebuffer. How it works with DRM KMS.

Suppose I compile DRM i1915 with KMS. How can I swich video mode on start 
and than from user space.
Normally with framebuffer it is IOCTL on /dev/fb.  Will it work or not?

Some explantion should ne enough, thanks 
