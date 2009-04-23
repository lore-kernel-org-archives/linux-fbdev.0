From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: DRM KMS + intel fb
Date: Thu, 23 Apr 2009 13:15:31 +0200
Message-ID: <49F04DD3.8020705@redhat.com>
References: <7398C9BACDA74507AA9FCCCE4847C5A4@avitech.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757830AbZDWLPv@vger.kernel.org>
In-Reply-To: <7398C9BACDA74507AA9FCCCE4847C5A4@avitech.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Peter Hanzel <hanzelpeter@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On 04/23/09 12:12, Peter Hanzel wrote:
> Hello.
>
> I am watching the KMS in DRM development. And now i want to try kernel
> modesetting with framebuffer console.
> I am only using console framebuffer. How it works with DRM KMS.

Just works.  The kms code supports the fb interface.

> Suppose I compile DRM i1915 with KMS. How can I swich video mode on
> start  and than from user space.

Loading the driver switches to the native resolution of the lcd monitor 
connected and runs a fbcon on it.  Didn't try to switching modes later.

HTH,
   Gerd
