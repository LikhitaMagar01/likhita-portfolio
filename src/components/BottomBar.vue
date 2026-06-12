<template>
  <div class="w-full">
    <nav class="hidden sm:flex fixed lg:static bottom-4 left-1/2 lg:left-auto transform lg:transform-none -translate-x-1/2 lg:translate-x-0 bg-gray-800 rounded-2xl shadow-lg px-6 py-2 space-x-6 items-center z-50 border border-gray-700 w-fit m-auto">
      <button
        v-for="item in navItems"
        :key="item.label"
        class="flex flex-col items-center text-gray-400 hover:text-green-400 focus:outline-none"
        :class="{ 'text-green-400': selectedSection === item.target }"
        @click="$emit('section-change', item.target)"
      >
        <i :class="item.icon + ' text-xl mb-1'" />
        <span class="text-xs hidden sm:block cursor-pointer">{{ item.label }}</span>
      </button>
    </nav>
    <button
      @click="isOpen = !isOpen"
      class="sm:hidden fixed top-4 right-4 z-50 bg-green-500 hover:bg-green-600 text-white p-1 rounded-full shadow-lg transition-all duration-300"
    >
      <svg v-if="!isOpen" class="w-6 h-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M13 1L13.001 4.06201C16.6192 4.51365 19.4869 7.38163 19.9381 11L23 11V13L19.938 13.001C19.4864 16.6189 16.6189 19.4864 13.001 19.938L13 23H11L11 19.9381C7.38163 19.4869 4.51365 16.6192 4.06201 13.001L1 13V11L4.06189 11C4.51312 7.38129 7.38129 4.51312 11 4.06189L11 1H13ZM12 10C10.8954 10 10 10.8954 10 12C10 13.1046 10.8954 14 12 14C13.1046 14 14 13.1046 14 12C14 10.8954 13.1046 10 12 10Z"></path></svg>
      <svg v-else class="w-6 h-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M6 6L18 18M6 18L18 6" stroke="currentColor" stroke-width="2" stroke-linecap="round"></path></svg>
    </button>
    <div
      v-if="isOpen"
      class="sm:hidden fixed top-16 right-4 z-40 bg-gray-800/95 backdrop-blur-sm rounded-2xl shadow-2xl border border-gray-700 p-2 w-48"
    >
      <button
        v-for="item in navItems"
        :key="item.target"
        @click="handleSectionChange(item.target)"
        class="w-full flex items-center px-4 py-3 rounded-xl text-gray-300 hover:text-green-400 hover:bg-gray-700/50 transition-all duration-200"
        :class="{ 'text-green-400 bg-gray-700/50': selectedSection === item.target }"
      >
        <i :class="item.icon + ' mr-3'" />
        <span>{{ item.label }}</span>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

defineProps<{ selectedSection: string }>()
const emit = defineEmits(['section-change'])

const isOpen = ref(false)

const navItems = [
  { icon: 'fas fa-home', label: 'Home', target: 'home' },
  { icon: 'fas fa-user', label: 'About', target: 'about' },
  { icon: 'fas fa-graduation-cap', label: 'Education', target: 'education' },
  { icon: 'fas fa-briefcase', label: 'Experience', target: 'experience' },
  { icon: 'fas fa-cogs', label: 'Projects', target: 'projects' },
  { icon: 'fas fa-layer-group', label: 'Skills', target: 'skills' },
  { icon: 'fas fa-envelope', label: 'Contact', target: 'contact' },
]

function handleSectionChange(target: string) {
  isOpen.value = false
  emit('section-change', target)
}
</script>
