From: James Simmons <jsimmons@infradead.org>
Subject: VesaFB/OFFb power management.
Date: Thu, 23 Oct 2003 00:09:30 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0310222359470.25125-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


I like to be able to suspend and resume these drivers. I noticed the 
SA1100 driver does this using struct device_driver. Is it possible to do 
this for VesaFB/OFFb ? What would be the bus field then?
